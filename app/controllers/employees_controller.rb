class EmployeesController < ApplicationController
    def show 
        @employee = Employee.find(params[:id])
        if params[:ticket_id] != nil 
            @employee.add_ticket(params[:ticket_id])
        end
    end
end