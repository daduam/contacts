class ContactsController < ApplicationController
    before_action :find_contact_by_id, only: [:show, :update, :destroy]

    def index
        @contacts = Contact.all
        render json: @contacts
    end

    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            render json: @contact
        else
            render error: { error: "Contact creation failed" }, status: 400    
        end
    end

    def show
        render json: @contact
    end

    def update
        if @contact
            @contact.update(contact_params)
            render json: { message: "Contact updated successfully" }, status: 200
        else
            render json: { error: "Contact update failed" }, status: 400
        end
    end

    def destroy
        if @contact
            @contact.destroy
            render json: { message: "Contact deleted successfully" }, status: 200
        else
            render json: { error: "Failed to delete contact" }, status: 400
        end
    end

    private

    def find_contact_by_id
        @contact = Contact.find(params[:id])
    end


    def contact_params
        params.require(:contact).permit(:name, :phone_number)
    end
end
