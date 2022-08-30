require 'rspec'
require_relative '../TC_generator'
require_relative '../clause'
require_relative '../section'


describe 'Clause' do

  let(:template) { File.readlines("template.txt")}

    context 'with valid group of clause objects' do
     it 'check valid group of clause objects for section' do  
        section = Section.new
        section.id = 1
        section_clauses = section.clauses       
        expect(section_clauses.first.class).to eq(Clause)
        expect(section_clauses.find { |clause| clause.id == 1 }).to_not be_nil
        expect(section_clauses.find { |clause| clause.id == 2 }).to_not be_nil
        expect(section_clauses.length).to eq(2)
     end
    end
end