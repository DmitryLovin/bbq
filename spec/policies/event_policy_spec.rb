require "rails_helper"
require "pundit/rspec"

RSpec.describe EventPolicy do
  let(:jar) { ActionDispatch::Cookies::CookieJar.new(nil) }

  let(:user) { UserContext.new(User.new, { cookies: jar, pincode: "" }) }
  let(:second_user) { UserContext.new(User.new, { cookies: jar, pincode: "" }) }
  let(:no_user) { UserContext.new(nil, { cookies: jar, pincode: "" }) }
  let(:event) { Event.new(user: user.user) }
  let(:event_w_pincode) { Event.new(user: user.user, pincode: "1234") }

  subject { EventPolicy }

  permissions :create? do
    it "grants access to create" do
      expect(subject).to permit(user, Event)
    end

    it "denied access to create" do
      expect(subject).not_to permit(no_user, Event)
    end
  end

  permissions :update? do
    context "when correct user" do
      it "grants access to update" do
        expect(subject).to permit(user, event)
      end
    end

    context "when no user" do
      it "denied access to create" do
        expect(subject).not_to permit(no_user, event)
      end
    end

    context "when second user" do
      it "denied access to create" do
        expect(subject).not_to permit(second_user, event)
      end
    end
  end

  permissions :show? do
    context "when no pincode" do
      it "grants access for owner" do
        expect(subject).to permit(user, event)
      end

      it "grants access for another user" do
        expect(subject).to permit(second_user, event)
      end

      it "grants access to anon" do
        expect(subject).to permit(no_user, event)
      end
    end

    context "when pincode present" do
      context "when user is owner" do
        it "grants access" do
          expect(subject).to permit(user, event_w_pincode)
        end
      end

      context "when user is anon" do
        it "denies access for anon" do
          expect(subject).not_to permit(no_user, event_w_pincode)
        end

        it "grants access for anon with correct cookies" do
          allow(no_user.params[:cookies]).to receive(:permanent).and_return({ "events_#{event_w_pincode.id}_pincode" => "1234" })
          expect(subject).to permit(no_user, event_w_pincode)
        end

        it "grants access for anon with pincode" do
          no_user.params[:pincode] = "1234"
          allow(no_user.params[:cookies]).to receive(:permanent).and_return({})
          expect(subject).to permit(no_user, event_w_pincode)
        end
      end

      context "when user is not an owner" do
        it "denies access for user" do
          expect(subject).not_to permit(second_user, event_w_pincode)
        end

        it "grants access for user with correct cookies" do
          allow(second_user.params[:cookies]).to receive(:permanent).and_return({ "events_#{event_w_pincode.id}_pincode" => "1234" })
          expect(subject).to permit(second_user, event_w_pincode)
        end

        it "grants access for user with pincode" do
          second_user.params[:pincode] = "1234"
          allow(second_user.params[:cookies]).to receive(:permanent).and_return({})
          expect(subject).to permit(second_user, event_w_pincode)
        end
      end
    end
  end
end
