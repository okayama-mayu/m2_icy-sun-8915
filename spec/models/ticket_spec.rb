require 'rails_helper'

RSpec.describe Ticket, type: :model do
    describe 'relationships' do
        it { should have_many :employee_tickets }
        it { should have_many(:employees).through(:employee_tickets) }
    end

    describe 'class methods' do 
        describe '#order_by_age' do 
            it 'orders tickets oldest to newest' do 
                EmployeeTicket.destroy_all
                Ticket.destroy_all 

                mid_old = Ticket.create!(subject: 'printer out of toner', age: 7)
                newest = Ticket.create!(subject: 'do not like my mouse', age: 1)
                oldest = Ticket.create!(subject: 'router broken', age: 10)
                mid_new = Ticket.create!(subject: 'cannot connect to internet', age: 4)

                expect(Ticket.order_by_age).to eq([oldest, mid_old, mid_new, newest])
            end
        end
    end
end