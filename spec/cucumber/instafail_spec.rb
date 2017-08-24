require 'spec_helper'
require 'cucumber/instafail'
require 'support/cucumber_spec_helper'
require 'cucumber/cli/main'
require 'cucumber/instafail'

module Cucumber
  describe Instafail do
    extend SpecHelperDsl
    include SpecHelper

    before(:each) do
      Cucumber::Term::ANSIColor.coloring = false
      @out = StringIO.new
      @options = Cucumber::Cli::Options.new
      @formatter = Instafail.new(runtime, @out, @options)
      run_defined_feature
    end

    context 'with a single passing scenario' do
      define_feature <<-FEATURE
        Feature: Banana party

          Scenario: Monkey eats banana
            Given there are bananas
      FEATURE

      define_steps do
        Given(/^there are bananas$/) { }
      end

      it 'outputs the passed step' do
        expect(@out.string).to include ".\n"
      end
    end

    context 'with a single failing scenario' do
      define_feature <<-FEATURE
        Feature: Banana party

          Scenario: Monkey eats banana
            Given there are bananas
      FEATURE

      define_steps do
        Given(/^there are bananas$/) do
          raise 'Unable to create the bananas'
        end
      end

      it 'outputs the failed step' do
        expect(@out.string).to include "F(::) failed steps (::)\n"
      end

      it 'outputs the error "Unable to create the bananas (RuntimeError)"' do
        message = 'Unable to create the bananas (RuntimeError)'
        expect(@out.string).to include message
      end

      it 'should have 1 scenario and 1 failure' do
        expect(@out.string).to include '1 scenario (1 failed)'
      end
    end

    context 'with multiple scenarios' do
      context 'and one failure' do
        define_feature <<-FEATURE
          Feature: Banana party

            Scenario: Monkey eats banana
              Given there are bananas
              When he eats the bananas
              Then the monkey should be happy

            Scenario: Gorilla eats banana
              Given there are bananas
              When he eats the bananas
              Then the gorilla should be happy

            Scenario: Lion eats banana
              Given there are bananas
              When he eats the bananas
              Then the lion should be happy

        FEATURE

        define_steps do
          Given(/^there are bananas$/) { }
          When(/^he eats the bananas$/) { }
          Then(/^the (?:monkey|lion) should be happy$/) { }
          Then(/^the gorilla should be happy$/) do
            raise 'The Gorilla is unhappy : ('
          end
        end

        it 'outputs the failed step' do
          expect(@out.string).to include "F(::) failed steps (::)\n"
        end

        it 'outputs the error "The Gorilla is unhappy : ( (RuntimeError)"' do
          message = 'The Gorilla is unhappy : ( (RuntimeError)'
          expect(@out.string).to include message
        end

        it 'should have 3 scenarios, 1 failure and 2 passed' do
          expect(@out.string).to include '3 scenarios (1 failed, 2 passed)'
        end
      end
      context 'and multiple failures' do
        define_feature <<-FEATURE
          Feature: Banana party

            Scenario: Monkey eats banana
              Given there are bananas
              When he eats the bananas
              Then the monkey should be happy

            Scenario: Gorilla eats banana
              Given there are bananas
              When he eats the bananas
              Then the gorilla should be happy

            Scenario: Lion eats banana
              Given there are bananas
              When he eats the bananas
              Then the lion should be happy

        FEATURE

        define_steps do
          Given(/^there are bananas$/) { }
          When(/^he eats the bananas$/) { }
          Then(/^the monkey should be happy$/) { }
          Then(/^the gorilla should be happy$/) do
            raise 'The Gorilla is unhappy : ('
          end
          Then(/^the lion should be happy$/) do
            raise 'The Lion is unhappy too'
          end
        end

        it 'outputs the failed step' do
          expect(@out.string).to include "F(::) failed steps (::)\n"
        end

        it 'outputs the error "The Gorilla is unhappy : ( (RuntimeError)"' do
          message = 'The Gorilla is unhappy : ( (RuntimeError)'
          expect(@out.string).to include message
        end

        it 'outputs the error "The Lion is unhappy : ( (RuntimeError)"' do
          message = 'The Lion is unhappy too (RuntimeError)'
          expect(@out.string).to include message
        end

        it 'should have 3 scenarios, 2 failures and 1 passed' do
          expect(@out.string).to include '3 scenarios (2 failed, 1 passed)'
        end

        it 'should not display duplicates' do
          header = "F(::) failed steps (::)\n\n"

          expected = "#{header}The Gorilla is unhappy : ( (RuntimeError)"
          expect(@out.string).to include expected

          expected = "#{header}The Lion is unhappy too (RuntimeError)"
          expect(@out.string).to include expected
        end
      end
    end
  end
end
