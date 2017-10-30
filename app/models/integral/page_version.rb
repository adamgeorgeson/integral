# Integral namespace
module Integral
  # Record PaperTrail of Integral::Page
  class PageVersion < PaperTrail::Version
     self.table_name = :integral_page_versions
     self.sequence_name = :page_versions_id_seq
  end
end
