#coding:utf-8
namespace :raf do
  namespace :db do
    task :fakify => :environment do
      Rubric.delete_all

      5.times do |i|
        rubric = Rubric.create name: "Rubric-#{i}", parent_id: ''
        5.times do |j|
          sub1 = Rubric.create name: "#{rubric.name}-#{j}", parent_id: rubric.id
          5.times do |k|
            sub2 = Rubric.create name: "#{sub1.name}-#{k}", parent_id: sub1.id
            5.times do |l|
              Rubric.create name: "#{sub2.name}-#{l}", parent_id: sub2.id
            end
          end
        end
      end
    end
  end
end