require 'rails_helper' 

RSpec.describe 'Employee Show' do 
    # Story 2
    # Employee Show
    # As a user,
    # When I visit the Employee show page,
    # I see the employee's name, department
    it 'shows the employees name and department' do 
        dept1 = Department.create!(name: 'IT', floor: 'Basement')
        emp1a = dept1.employees.create!(name: 'Mariah Carey', level: 'mid')
        emp1b = dept1.employees.create!(name: 'Ariana Grande', level: 'entry')

        visit "/employees/#{emp1a.id}"
        # save_and_open_page

        expect(page).to have_content('Mariah Carey')
        expect(page).to have_content('Department: IT')
        expect(page).to_not have_content('Ariana Grande')
    end


    # and a list of all of their tickets from oldest to youngest.
    it 'shows the employees tickets from oldest to youngest' do 
        dept1 = Department.create!(name: 'IT', floor: 'Basement')
        emp1a = dept1.employees.create!(name: 'Mariah Carey', level: 'mid')

        mid_old = Ticket.create!(subject: 'printer out of toner', age: 7)
        newest = Ticket.create!(subject: 'do not like my mouse', age: 1)
        oldest = Ticket.create!(subject: 'router broken', age: 10)
        mid_new = Ticket.create!(subject: 'cannot connect to internet', age: 4)

        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: mid_old.id)
        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: newest.id)
        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: oldest.id)
        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: mid_new.id)

        visit "/employees/#{emp1a.id}"
        # save_and_open_page

        within("#ticket-0") do 
            expect(page).to have_content('router broken')

            expect(page).to_not have_content('printer out of toner')
        end

        within("#ticket-1") do 
            expect(page).to have_content('printer out of toner')

            expect(page).to_not have_content('do not like my mouse')
        end

        within("#ticket-2") do 
            expect(page).to have_content('cannot connect to internet')

            expect(page).to_not have_content('router broken')
        end

        within("#ticket-3") do 
            expect(page).to have_content('do not like my mouse')

            expect(page).to_not have_content('cannot connect to internet')
        end
    end
    
    # I also see the oldest ticket assigned to the employee listed separately
    it 'shows the oldest ticket separately as the current ticket' do 
        dept1 = Department.create!(name: 'IT', floor: 'Basement')
        emp1a = dept1.employees.create!(name: 'Mariah Carey', level: 'mid')

        mid_old = Ticket.create!(subject: 'printer out of toner', age: 7)
        newest = Ticket.create!(subject: 'do not like my mouse', age: 1)
        oldest = Ticket.create!(subject: 'router broken', age: 10)
        mid_new = Ticket.create!(subject: 'cannot connect to internet', age: 4)

        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: mid_old.id)
        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: newest.id)
        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: oldest.id)
        EmployeeTicket.create!(employee_id: emp1a.id, ticket_id: mid_new.id)

        visit "/employees/#{emp1a.id}"
        # save_and_open_page
        
        within("#current-ticket") do 
            expect(page).to have_content('Current Ticket: router broken')

            expect(page).to_not have_content('printer out of toner')
        end
    end
end