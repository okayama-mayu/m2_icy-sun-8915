class Ticket < ApplicationRecord
    has_many :employee_tickets
    has_many :employees, through: :employee_tickets

    def self.order_by_age
        order(age: :desc)
    end
end