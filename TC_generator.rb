require 'byebug' 
require_relative 'clause'
require_relative 'section'
require_relative 'template_data'

class TC_generator

	#initializing template, clauses and sections for new T&C document
	def initialize(template)
		@template = template	
		@clauses = Clause.get_dataset
	end

	def create_document		
		begin
			new_document = transform_template
		rescue => error
			return error
		end
	end


	private

	#Creates the new T&C document
	def transform_template
		
			new_document = ''
			raise StandardError.new("No template data found!!") if @template.length == 0
			@template.each do |line|
				str = line[/(?<=\[).*?(?=\])/]
				if !str.nil?
					if str.include?('CLAUSE')
						line = get_clauses_data(str, line)
					elsif str.include?('SECTION')
						line = get_sections_data(str, line)
					end
				end
				new_document += line 
			end
			return new_document
		
	end

	#adds new clauses data to T&C document
	def get_clauses_data(str, line)
		clause_id = str.split("-").last.to_i
		clause = @clauses.select{|clause| clause if clause.id == clause_id}.first
		if !clause.nil?
			clause_text = clause.text
			line = line.gsub("[#{str}]", clause_text) if clause_text.length > 1	
		end
		line
	end

	#adds section's clauses data to T&C document
	def get_sections_data(str, line)
		section_id, clauses_text = str.split("-").last.to_i, ''
		section = Section.new
		section.id = section_id
		section_clauses = section.clauses
		section_clauses.each_with_index do |section_clause, i|
			clause_text = section_clause.text			
			clauses_text += clause_text
			clauses_text += ";" if (i != (section_clauses.length - 1))
		end

		if clauses_text.length > 1
			line = line.gsub("[#{str}]", clauses_text) 
		else
			line
		end
	end

end



template = File.readlines("template.txt")	
tc_generator = TC_generator.new(template)
puts "====================Output====================\n\n"
puts tc_generator.create_document
