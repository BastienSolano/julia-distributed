# julia-distributed

Pour réserver les nodes (remplacer 2 par le nombre de nodes désiré):
```console
oarsub -l nodes=2 -I -t allow_classic_ssh
```
Cela lance une session intéractive (attention donc: exit termine tout le job et pas seulement ce node).

Après avoir réservé les nodes (si tout ça n'est pas déjà fait sur votre user g5k):
```console
wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.1-linux-x86_64.tar.gz
tar zxvf julia-1.7.1-linux-x86_64.tar.gz
export PATH="$PATH:$HOME/julia-1.7.1/bin"
git clone https://github.com/BastienSolano/julia-distributed.git
```

Pour lancer en distribué sur tous les nodes:
```console
cd distributed_julia
uniq $OAR_NODEFILE > hosts.txt
julia --machine-file=hosts.txt main.jl
``` 
Par défaut, julia ne lance qu'un thread par machine, pour changer cela, il faut modifier hosts.txt (see https://docs.julialang.org/en/v1/manual/distributed-computing/#Starting-and-managing-worker-processes)

J'ai l'impression qu'il ne faut pas mettre plusieurs workers sur le master (premier node du fichier) car sinon on a un problème de file handle avec le 
NFS. (A mon avis, c'est dû au fait que julia essaie de faire un ssh du master vers lui-même)
