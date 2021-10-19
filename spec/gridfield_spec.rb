require_relative '..\lib\GridField.rb'

describe GridField do
    describe '#new' do
      context 'when new gridfield is created' do
        subject(:gridfield_new) { described_class.new }
        it 'contains only blank spaces' do
          fields = gridfield_new.instance_variable_get(:@content).flatten
          expect(fields).to all(eq(" "))
        end
      end
    end

    describe '#rowCompleted?' do
      subject(:gridfield_rows) { described_class.new }
      context 'when first row contains only similar characters' do
        it 'is completed' do
          gridfield_rows.setCell(0, 0, 'x')
          gridfield_rows.setCell(0, 1, 'x')
          gridfield_rows.setCell(0, 2, 'x')
          result = gridfield_rows.rowCompleted? 0
          expect(result).to be true
        end
      end

      context 'when second row contains different characters' do
        it 'is not completed' do
          gridfield_rows.setCell(1, 0, 'x')
          gridfield_rows.setCell(1, 1, 'o')
          gridfield_rows.setCell(1, 2, 'x')
          result = gridfield_rows.rowCompleted? 1
          expect(result).to be false
        end
      end
    end

    describe '#columnCompleted?' do
      subject(:gridfield_columns) { described_class.new }
      context 'when first column contains only similar characters' do
        it 'is completed' do
          gridfield_columns.setCell(0, 0, 'x')
          gridfield_columns.setCell(1, 0, 'x')
          gridfield_columns.setCell(2, 0, 'x')
          result = gridfield_columns.columnCompleted? 0
          expect(result).to be true
        end
      end

      context 'when second column contains different characters' do
        it 'is not completed' do
          gridfield_columns.setCell(0, 1, 'x')
          gridfield_columns.setCell(1, 1, 'o')
          gridfield_columns.setCell(2, 1, 'x')
          result = gridfield_columns.columnCompleted? 1
          expect(result).to be false
        end
      end
    end

end