# nf-channel-error

Example workflow where channels can mix loosing the synchronization with the input files


```mermaid
graph TD;
  INPUT -- reads --> ASSEMBLE;
  INPUT -- reads -->   MAP;
  ASSEMBLE --> MAXBIN;
  C-->D;
```

```mermaid
graph DAG;
  INPUT -- reads --> ASSEMBLE;
  ASSEMBLE --> MAXBIN;
  ASSEMBLE --> INDEX;
  INDEX --> MAP;
  MAP --> DEPTHS;
  DEPTHS --> METABAT2;
  INPUT -- reads  --> MAP;
```
