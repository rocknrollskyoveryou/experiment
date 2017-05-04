module NetLibrary

  class << self
    def create_net_generator(time_mean)
      places = [Dess::Place.new(name: 'P1', mark: 1),
                Dess::Place.new(name: 'P2', mark: 0)]
      transitions = [Dess::Transition.new(name: 'T1', param: time_mean, distribution: 'exp')]
      incoming = [Dess::IncomingArc.new(place: places[0], transition: transitions[0], multiplicity: 1)]
      outgoing = [Dess::OutgoingArc.new(place: places[1], transition: transitions[0], multiplicity: 1),
                  Dess::OutgoingArc.new(place: places[0], transition: transitions[0], multiplicity: 1)]
      net = Dess::PetriNet.new(places: places, transitions: transitions,
                         incoming_arcs: incoming, outgoing_arcs: outgoing)
      reset
      net
    end

    def create_smo_group(num_in_group, num_channel, time_mean, name)
      places = [Dess::Place.new(name: 'P0', mark: 0)]
      transitions = []
      incoming = []
      outgoing = []
      for i in 0..num_in_group
        places.push(Dess::Place.new(name: "P" + (2 * i + 1).to_s, mark: num_channel))
        places.push(Dess::Place.new(name: "P" + (2 * i + 2).to_s, mark: 0))
        transitions.push(Dess::Transition.new(name: "T"+i.to_s, param: time_mean, distribution: 'exp'))
        incoming.push(Dess::IncomingArc.new(place: places[2 * i], transition: transitions[i], multiplicity: 1))
        incoming.push(Dess::IncomingArc.new(place: places[2 * i + 1], transition: transitions[i], multiplicity: 1))
        outgoing.push(Dess::OutgoingArc.new(place: places[2 * i + 1], transition: transitions[i], multiplicity: 1))
        outgoing.push(Dess::OutgoingArc.new(place: places[2 * i + 2], transition: transitions[i], multiplicity: 1))
      end
      net = Dess::PetriNet.new(name: name, places: places, transitions: transitions,
                         incoming_arcs: incoming, outgoing_arcs: outgoing)
      reset
      net
    end

    private

    def reset
      Dess::Place.next = 0
      Dess::Transition.next = 0
      Dess::IncomingArc.next = 0
      Dess::OutgoingArc.next = 0
    end
  end
end