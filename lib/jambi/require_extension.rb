module Jambi::RequireExtension
  def require(*args, &block)
    candidates = Jambi.gems(args.first)
    return super if candidates.empty?

    if args.size == 1
      $: << candidates.last.lib_dir
    else
    end

    super
  end
end

