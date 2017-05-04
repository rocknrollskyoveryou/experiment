require './net_library'
require 'dess'

def smo_group(num_groups, num_in_group)
  list = []
  num_smo = num_groups - 1

  list.push(Dess::Simulation.new(NetLibrary.create_net_generator(2.0)))

  for i in 0..num_smo
    list.push(Dess::Simulation.new(NetLibrary.create_smo_group(num_in_group, 1, 1.0, 'group_'+i.to_s)))
  end

  list[0].net.places[1] = list[1].net.places[0]

  if num_smo > 1
    for i in 2...num_smo
      list[i].net.places[0] = list[i-1].net.places.last
    end
  end

  Dess::ObjectModel.new(list)
end

def print(model)
  model.sim_list.each do |sim|
    puts sim.net.places.last
  end
end

def main
  num_obj = 5
  model = smo_group(num_obj, 5)
  time_modeling = 100
  model.go(time_modeling)
  print(model)
end

main