require 'byebug'
require_relative 'template_data'

class Section
	attr_accessor :id

	attr_reader :clauses

	#creating group of clause objects for a section
	def clauses
		clauses_ids = TemplateData::SECTIONS.select{|section| section if section[:id] == @id}.first[:clauses_ids]
		clauses_arr = Clause.get_dataset.select{|clause| clause if clauses_ids.length > 0 && clauses_ids.include?(clause.id)}
	end

end

