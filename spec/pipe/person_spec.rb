# frozen_string_literal: true

RSpec.describe Pipe::Person do
  context "#entity" do
    context "#find" do

      subject { described_class.find(1) }

      it 'should return new person' do
        expect(subject).to be_kind_of(Pipe::Person)
        expect(subject.id).to eq(1)
      end

      it 'should raise Pipe::Exception::AttributeError with id = nil' do
        expect { described_class.find(nil) }.
          to raise_error(Pipe::Exception::AttributeError)
      end
    end

    context "#update" do

      subject { described_class.update(1, name: 'Example Person2') }

      it 'should return updated person' do
        expect(subject).to be_kind_of(Pipe::Person)
        expect(subject.name).to eq('Example Person2')
      end

      it 'should raise Pipe::Exception::AttributeError with id = nil' do
        expect { described_class.update(nil, foo: 'bar') }.
          to raise_error(Pipe::Exception::AttributeError)
      end
    end

    context "#delete" do

      subject { described_class.delete(1) }

      it 'should delete exisiting person' do
        expect(subject).to be_kind_of(TrueClass)
      end

      it 'should raise Pipe::Exception::AttributeError with id = nil' do
        expect { described_class.delete(nil) }.
          to raise_error(Pipe::Exception::AttributeError)
      end
    end
  end

  context "#class_methods" do
    context "#fields" do
      it 'should return preson fields' do
        expect(described_class.fields).to be_kind_of(Array)
        expect(described_class.fields.first).to be_kind_of(Pipe::Field)
      end
    end
  end

  context "#instance_methods" do
    let(:person_with_org) { described_class.find(1) }
    let(:person_without_org) { described_class.find(2) }

    context "#organization" do
      it 'should return organization linked to person' do
        expect(person_with_org.organization).to be_kind_of(Pipe::Organization)
      end

      it 'should return nil' do
        expect(person_without_org.organization).to eq(nil)
      end
    end
  end
end
