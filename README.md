# julia-distributed

Après avoir réservé le node:
```console
wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.1-linux-x86_64.tar.gz
tar zxvf julia-1.7.1-linux-x86_64.tar.gz
export PATH="$PATH:$HOME/julia-1.7.1/bin"
git clone https://github.com/BastienSolano/julia-distributed.git
cd julia-distributed
```

(Pour lancer en parallèle sur 4 threads)
```console
julia -p 4 main.jl
```
