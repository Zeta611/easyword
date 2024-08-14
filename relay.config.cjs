module.exports = {
  src: "./src",
  schema: "./schema.graphql",
  artifactDirectory: "./src/__generated__",
  customScalarTypes: {
    timestamptz: "string",
    uuid: "string",
    seed_float: "string",
  },
};
