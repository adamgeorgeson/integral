# Integral namespace
module Integral
  # Record PaperTrail of Integral::Post
  class PostVersion < PaperTrail::Version
     self.table_name = :integral_post_versions
     self.sequence_name = :post_versions_id_seq
  end
end
