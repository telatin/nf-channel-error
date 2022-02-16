# nf-channel-error

Example workflow where channels can mix loosing the synchronization with the input files

![Alt text](https://g.gravizo.com/source/custom_mark10?https%3A%2F%2Fraw.githubusercontent.com%2FTLmaK0%2Fgravizo%2Fmaster%2FREADME.md)
<details> 
<summary></summary>
digraph "dag" {
p0 [shape=point,label="",fixedsize=true,width=0.1,xlabel="Channel.fromFilePairs"];
p1 [label="ASSEMBLE"];
p0 -> p1 [label="reads"];

p1 [label="ASSEMBLE"];
p2 [label="INDEX"];
p1 -> p2;

p2 [label="INDEX"];
p3 [label="MAP"];
p2 -> p3;

p0 [shape=point,label="",fixedsize=true,width=0.1,xlabel="Channel.fromFilePairs"];
p3 [label="MAP"];
p0 -> p3 [label="reads"];

p3 [label="MAP"];
p6 [label="DEPTHS"];
p3 -> p6;

p0 [shape=point,label="",fixedsize=true,width=0.1,xlabel="Channel.fromFilePairs"];
p4 [label="MAXBIN"];
p0 -> p4 [label="reads"];

p1 [label="ASSEMBLE"];
p4 [label="MAXBIN"];
p1 -> p4;

p4 [label="MAXBIN"];
p5 [shape=point];
p4 -> p5;

p6 [label="DEPTHS"];
p7 [label="METABAT2"];
p6 -> p7;

p1 [label="ASSEMBLE"];
p7 [label="METABAT2"];
p1 -> p7;

p7 [label="METABAT2"];
p8 [shape=point];
p7 -> p8;

}

</details>
