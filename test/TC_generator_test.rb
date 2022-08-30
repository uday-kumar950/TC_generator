require 'rspec'
require 'byebug' 
require_relative '../TC_generator'
require_relative '../clause'
require_relative '../section'


describe 'TC_generator' do

  let(:template) { File.readlines("template.txt")}

  context "with blank template" do
     it "check empty template" do
      tc_generator = TC_generator.new([])
      new_document = tc_generator.create_document
      expect(new_document.message).to eq("No template data found!!")
     end
  end  
    

  context 'with absence of clause 3' do
    TemplateData::CLAUSES = [{ "id": 1, "text": "The quick brown fox" },
      { "id": 2, "text": "jumps over the lazy dog" },
      { "id": 4, "text": "The white horse is white" }]

     it 'check unchanged text if clauses id not present' do
      tc_generator = TC_generator.new(template)
      new_document = tc_generator.create_document
      expect(new_document).to include("[CLAUSE-3]")
    end
  end


  context "with absence of section's clauses_ids" do
    TemplateData::CLAUSES = [{ "id": 1, "text": "The quick brown fox" },
      { "id": 2, "text": "jumps over the lazy dog" },
      { "id": 3, "text": "And dies" },
      { "id": 4, "text": "The white horse is white" }]

    TemplateData::SECTIONS = [{ "id": 1, "clauses_ids": [] }]

     it "check unchanged text if section's clauses_ids not present" do
      tc_generator = TC_generator.new(template)
      new_document = tc_generator.create_document
      expect(new_document).to include("[SECTION-1]")
     end
  end


  context "with absence of sections clauses_ids and clauses" do
    TemplateData::CLAUSES = []
    TemplateData::SECTIONS = [{ "id": 1, "clauses_ids": [] }]

     it "check unchanged text if section's clauses_ids and clauses not present" do
      tc_generator = TC_generator.new(template)
      new_document = tc_generator.create_document
      expect(new_document).to include("[CLAUSE-3]")
      expect(new_document).to include("[CLAUSE-4]")
      expect(new_document).to include("[SECTION-1]")
     end
  end

  context 'with valid template data' do
     it 'check correct transformed template' do    
        TemplateData::CLAUSES = [{ "id": 1, "text": "The quick brown fox" },
      { "id": 2, "text": "jumps over the lazy dog" },
      { "id": 3, "text": "And dies" },
      { "id": 4, "text": "The white horse is white" }]
      TemplateData::SECTIONS = [{ "id": 1, "clauses_ids": [1, 2] }]

        tc_generator = TC_generator.new(template)
        new_document = tc_generator.create_document
        expect(new_document).to eq('A T&C Document

This document is made of plaintext.
Is made of And dies.
Is made of The white horse is white.
Is made of The quick brown fox;jumps over the lazy dog.

Your legals.') 

      end
    end

  end


