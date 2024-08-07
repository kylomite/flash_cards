require './lib/deck'
require './lib/turn'

class Round

    attr_reader :deck,
                :turns, 
                :turn,
                :current_card,
                :take_turn,
                :number_correct,
                :percent_correct,
                :number_correct_by_category,
                :percent_correct_by_category
    
    
    def initialize(deck)
        @deck = deck
        @turns = []
        @current_card = deck.cards[0]
        @turn = turn
        @number_correct = 0
        @correct_turn = []
        

    end
    
    def take_turn(user_guess)
        if user_guess.class != String
            "Your guess must be a string"
        else 
            @turn = Turn.new(user_guess, @current_card)
            @turns.push(@turn)
            @deck.cards.rotate!
            @current_card = @deck.cards[0]
            if @turn.correct?
                @correct_turn.push(@turn)
                @number_correct += 1
            end
            @turn
        end
    end

    def number_correct
        @number_correct
    end

    def percent_correct
       percent_fig1 =  @number_correct.to_f
       percent_fig2 = @turns.length.to_f
       
       
       (percent_fig1 / percent_fig2) * 100
    end

    def number_correct_by_category(cat)
        correct_answer_per_cat = 0
            @correct_turn.each {|x|
                if x.card.category == cat
                    correct_answer_per_cat += 1
                end
            }
        return correct_answer_per_cat
    end

    def percent_correct_by_category(cat)
        correct_answer_per_cat = 0
            @correct_turn.each {|x|
                if x.card.category == cat
                    correct_answer_per_cat += 1
                end
            }

        total_answer_per_cat = 0
            @turns.each {|x|
                if x.card.category == cat
                    total_answer_per_cat += 1
                end
            }
        
        percent_fig1 = correct_answer_per_cat.to_f
        percent_fig2 = total_answer_per_cat.to_f

        (percent_fig1 / percent_fig2) * 100
    end
end