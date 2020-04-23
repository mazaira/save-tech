namespace :meta do
  desc 'Import meta for the items which miss it'
  task :import => :environment do
    Item.where(title: nil).map do |item|
      begin
        resp = Faraday.get(ENV['META_URL'], {url: item.link}, {'Authorization' => ENV['META_KEY']})
        meta = JSON.parse(resp.body)['meta']

        next unless meta
        item.update_attributes(
          description: meta['description'],
          image:       meta['image'],
          title:       meta['title'],
        )
      rescue StandardError => e
        puts "Problem with record id: #{item.id}"
        puts e.message
      end
    end
  end
end

