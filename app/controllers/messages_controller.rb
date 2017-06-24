class MessagesController < ApplicationController
  before_action :require_login, :only => [:new, :create, :index]

  def index
    if params[:type] == 'sent'
      @messages = current_user.outbound_messages
    else
      @messages = current_user.inbound_messages
    end
  end

  def new
    if params[:recipient_id].present?
      @message = Message.new(:recipient_id => params[:recipient_id])
    else
      @message = Message.new
    end
  end

  def show
    @message = Message.find_by_id(params[:id])
    if @message.present?
      if @message.sender != current_user && @message.recipient != current_user
        flash[:error] = "Messsage Not Found..."
        redirect_to messages_path
      end

      if @message.recipient == current_user
        @message.status = 'read'
        @message.save
      end
    else
      flash[:error] = "Messsage Not Found..."
      redirect_to messages_path
    end
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.status = 'unread'
    if @message.save
      flash[:success] = "Message sent..."
      redirect_to messages_path(:type => 'sent')
    else
      flash.now[:error] = @message.errors.full_messages
      render 'new'
    end
  end

  private
  def message_params
    params.require(:message).permit(:recipient_id, :subject, :body)
  end
end
