json.array!(@rubrics) do |rubric|
  json.extract! rubric, :id, :name, :parent_id
  json.url rubric_url(rubric, format: :json)
  json.nodes []
end
