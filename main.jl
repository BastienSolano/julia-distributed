using Distributed

@everywhere begin
  # instantiate and precompile environment
  using Pkg; Pkg.activate(@__DIR__)
  Pkg.add("ProgressMeter"); Pkg.add("CSV"); Pkg.add("DataFrames")
  Pkg.instantiate(); Pkg.precompile()
end


@everywhere begin
# load dependencies
  using ProgressMeter
  using CSV
  using DataFrames

  # helper functions
  function process(infile, outfile)
    # read file from disk
    csv = CSV.read(infile, DataFrame; normalizenames=true)

    # perform calculations
    sleep(1) # pretend it takes time
    csv.new = rand(size(csv,1))

    # save new file to disk
    CSV.write(outfile, csv)
  end
end

# MAIN SCRIPT
# -----------

# relevant directories
indir  = joinpath(@__DIR__,"data")
outdir = joinpath(@__DIR__,"results")

# files to process
infiles  = readdir(indir, join=true)
outfiles = joinpath.(outdir, basename.(infiles))
nfiles   = length(infiles)

# ----------------------------
# Implementation sequentielle:
# ----------------------------
#@showprogress for i in 1:nfiles
#  process(infiles[i], outfiles[i])
#end


status = @showprogress pmap(1:nfiles) do i
  try
    process(infiles[i], outfiles[i])
    true #return success
  catch e
    false #return error
  end
end
