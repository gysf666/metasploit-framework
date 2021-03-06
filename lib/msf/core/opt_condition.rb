# -*- coding: binary -*-
module Msf
  module OptCondition

    # Check a condition's result
    def self.eval_condition(left_value, operator, right_value)
      case operator.to_sym
      when :==
        right_value == left_value
      when :!=
        right_value != left_value
      when :in
        right_value.include?(left_value)
      when :nin
        !right_value.include?(left_value)
      end
    end

    # Check an OPTION conditions. This function supports
    # dump_options()
    def self.show_option(mod, opt)
      return true if opt.conditions.empty?

      left_source = opt.conditions[0]
      operator = opt.conditions[1]
      right_value = opt.conditions[2]
      if left_source == 'ACTION'
        left_value = mod.action.name.to_s
      elsif left_source == 'TARGET'
        left_value = mod.target.name.to_s
      else
        left_value = mod.datastore[left_source] || opt.default
      end

      eval_condition(left_value, operator, right_value)
    end

  end
end
