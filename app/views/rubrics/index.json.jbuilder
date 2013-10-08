json.array!(@rubrics) do |rubric|
  json.extract! rubric, :name, :parent_id
  json.url rubric_url(rubric, format: :json)
end
