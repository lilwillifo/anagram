class Anagram < ApplicationRecord
  validates_presence_of :key
  has_many :words
end
