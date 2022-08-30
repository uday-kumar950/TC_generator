	require_relative 'section'
	require_relative 'template_data'
	
	class Clause < Section
		attr_accessor :id, :text

		#creating clause objects
		def self.get_dataset
			clauses_data = TemplateData::CLAUSES
			clauses = Array.new
			clauses_data.each do |clause|
				new_clause = Clause.new
				new_clause.id = clause[:id]
				new_clause.text = clause[:text]
				clauses << new_clause
			end

			return clauses			
		end

	end
