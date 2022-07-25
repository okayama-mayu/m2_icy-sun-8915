require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'relationships' do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  describe 'instance methods' do 
    describe '#add_ticket' do 
      it 'adds a new ticket to the employees ticket list' do 
        dept1 = Department.create!(name: 'IT', floor: 'Basement')
        emp1a = dept1.employees.create!(name: 'Mariah Carey', level: 'mid')

        mid_old = Ticket.create!(subject: 'printer out of toner', age: 7)
        newest = Ticket.create!(subject: 'do not like my mouse', age: 2)
        oldest = Ticket.create!(subject: 'router broken', age: 10)
        mid_new = Ticket.create!(subject: 'cannot connect to internet', age: 4)

        unassigned = Ticket.create!(subject: 'email issues', age: 1)
        unassigned2 = Ticket.create!(subject: 'cant start computer', age: 1)

        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: mid_old.id)
        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: newest.id)
        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: oldest.id)
        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: mid_new.id)

        emp1a.add_ticket(unassigned.id)
        
        expect(emp1a.tickets).to eq([mid_old, newest, oldest, mid_new, unassigned])
      end
    end
  end
end