require 'rails_helper' 

RSpec.describe 'Department Index' do 
    # Story 1
    # Department Index
    # As a user,
    # When I visit the Department index page,
    # I see each department's name and floor
    it 'displays each departments name and floor' do 
        dept1 = Department.create!(name: 'IT', floor: 'Basement')
        dept2 = Department.create!(name: 'Cleaning', floor: 'First')
        dept3 = Department.create!(name: 'HR', floor: 'Second')

        visit '/departments' 
        # save_and_open_page

        within("#department-#{dept1.id}") do 
            expect(page).to have_content('IT')
            expect(page).to have_content('Floor: Basement')
            expect(page).to_not have_content('Cleaning')
        end

        within("#department-#{dept2.id}") do 
            expect(page).to have_content('Cleaning')
            expect(page).to have_content('Floor: First')
            expect(page).to_not have_content('HR')
        end

        within("#department-#{dept3.id}") do 
            expect(page).to have_content('HR')
            expect(page).to have_content('Floor: Second')
            expect(page).to_not have_content('IT')
        end
    end

    # And underneath each department, I can see the names of all of its employees
    it 'displays the names of each departments employees' do 
        dept1 = Department.create!(name: 'IT', floor: 'Basement')
        emp1a = dept1.employees.create!(name: 'Mariah Carey', level: 'mid')
        emp1b = dept1.employees.create!(name: 'Ariana Grande', level: 'entry')
        emp1c = dept1.employees.create!(name: 'Aretha Franklin', level: 'senior')

        dept2 = Department.create!(name: 'Cleaning', floor: 'First')
        emp2a = dept2.employees.create!(name: 'Robert Kardashian', level: 'mid')
        emp2b = dept2.employees.create!(name: 'Harry Styles', level: 'senior')

        dept3 = Department.create!(name: 'HR', floor: 'Second')
        emp3a = dept3.employees.create!(name: 'Viola Davis', level: 'senior')

        visit '/departments' 
        # save_and_open_page

        within("#department-#{dept1.id}") do 
            expect(page).to have_content('Mariah Carey')
            expect(page).to have_content('Ariana Grande')
            expect(page).to have_content('Aretha Franklin')

            expect(page).to_not have_content('Harry Styles')
        end

        within("#department-#{dept2.id}") do 
            expect(page).to have_content('Robert Kardashian')
            expect(page).to have_content('Harry Styles')

            expect(page).to_not have_content('Viola Davis')
        end

        within("#department-#{dept3.id}") do 
            expect(page).to have_content('Viola Davis')

            expect(page).to_not have_content('Ariana Grande')
        end
    end
end