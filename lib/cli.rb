BEET='beet'

class Cli < Thor
  desc 'diff', 'Compares contents of regular and backup libraries'
  def diff
    Helpers.exec "vimdiff #{recursive_ls(LIBRARY)} #{recursive_ls(BACKUP)}"
  end

  desc 'lonely', 'Checks for flacs without mp3s'
  def lonely
    lonely = []
    Dir.glob("#{LIBRARY}**/*.flac") do |file|
      is_lonely = !File.exists?(file.downcase.gsub(/.flac$/, '.mp3'))
      is_lonely = is_lonely && !File.exists?(file.downcase.gsub(/.flac$/, '.m4a'))

      lonely << file if is_lonely
    end

    if not lonely.empty?
      lonely.each { |f| puts f }
    else
      puts '✓ All your flacs have matching mp3s, yay.'
    end
  end

  desc 'import', 'Imports files from ~/Downloads (including converting and backing up)'
  def import
    loop do
      print 'Have you tagged your files? Yes, No (Y): '

      answer = STDIN.gets.chomp.downcase
      answer = 'y' if answer.blank?

      case answer
      when 'y'
        break
      when 'n'
        return 1
      end
    end

    puts 'Importing files with beets...'

    result = Helpers.exec "#{BEET} import -Ag #{DOWNLOADED}"

    puts ''

    if result
      puts '✓ Library successfully imported'
      puts ''
      puts "It's recommended that you now `beet udpate` so as to fix any little beet issues (such as not tagging compilations correctly)."
    else
      puts '✗ Library failed to import'
    end
  end

  desc 'dup', 'Show duplicate tracks'
  def dup
    dups = Helpers.read_exec "#{BEET} ls -f '$artist - $album - $title $format' | sort | uniq -d"

    if dups.empty?
      puts '✓ No duplicates in your library!'
    else
      puts dups
    end
  end

  desc 'flac', 'Show percentage of library in flac format'
  def flac
    total = Helpers.read_exec "#{BEET} ls -f '$artist - $album - $title' ^format:FLAC | sort -u | wc -l"
    total_flac = Helpers.read_exec "#{BEET} ls -f '$artist - $album - $title' format:FLAC | sort -u | wc -l"
    ratio = total_flac.to_f / total.to_f

    if ratio > 0.5
      puts "Nice, #{'%.0f' % (ratio * 100)}% of your library are flacs."
    else
      puts "Oh, only #{'%.0f' % (ratio * 100)}% of your library are flacs."
    end
  end

  desc 'sync', 'Sync the contents of the main library with the backup library'
  def sync
    result = Helpers.exec "rsync -auv #{LIBRARY} #{BACKUP}"

    puts ''

    if result
      puts '✓ Library successfully synced'
    else
      puts '✗ Library failed to sync'
    end
  end

  private

  def recursive_ls(location)
    "<(ls -1R #{location} | grep 'mp3\\|flac\\|m4a')"
  end
end
