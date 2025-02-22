require "test_helper"

module Messages
  class ReadIndicatorComponentTest < ViewComponent::TestCase
    setup do
      @conversation = conversations(:one)
      @user = users(:subscribed_business)
    end

    test "should render nothing if conversation has no messages" do
      @conversation.messages.destroy_all
      render_inline Conversations::ReadIndicatorComponent.new(@user, conversation: @conversation)

      assert_no_text "Message read."
      assert_no_text "Message unread."
    end

    test "should render nothing if latest message is not from sender" do
      user = users(:developer)
      render_inline Conversations::ReadIndicatorComponent.new(user, conversation: @conversation)

      assert_no_text "Message read."
      assert_no_text "Message unread."
    end

    test "should render message read when show_read? is true" do
      @conversation.latest_message.notifications_as_message.mark_as_read!
      render_inline Conversations::ReadIndicatorComponent.new(@user, conversation: @conversation)

      assert_text "Message read."
    end

    test "should render message unread when show_read? is false" do
      render_inline Conversations::ReadIndicatorComponent.new(@user, conversation: @conversation)

      assert_text "Message unread."
    end
  end
end
