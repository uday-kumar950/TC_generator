require 'rspec'
require_relative '../TC_generator'
require_relative '../clause'
require_relative '../section'


describe 'Clause' do

  let(:template) { File.readlines("template.txt")}
  
    context 'with valid clause objects' do
     it 'check valid clause objects' do  
        clauses = Clause.get_dataset        
        expect(clauses.first.class).to eq(Clause)
        expect(clauses.find { |clause| clause.id == 1 }).to_not be_nil
        expect(clauses.find { |clause| clause.id == 2 }).to_not be_nil
        expect(clauses.find { |clause| clause.id == 3 }).to_not be_nil
        expect(clauses.find { |clause| clause.id == 4 }).to_not be_nil
        expect(clauses.length).to eq(4)
     end
    end
 end