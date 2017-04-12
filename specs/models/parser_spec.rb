require_relative '../../app/models/parser'
require_relative '../../app/models/talk'

describe Parser do
  describe '#parse' do
    it 'it should parse given file and return list of talks' do
      contents = ['Talk 20min',
                  'Talk lightning']
      expect(File).to receive(:readlines).with('file_path').and_return(contents)

      talks = Parser.parse('file_path')

      expect(talks.count).to eq(2)
      expect(talks[0].title).to eq('Talk 20min')
      expect(talks[0].duration).to eq(20)

      expect(talks[1].title).to eq('Talk lightning')
      expect(talks[1].duration).to eq(5)
    end
  end
end
