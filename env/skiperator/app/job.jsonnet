{
  apiVersion: 'v1',
  items: [
    {
      apiVersion: 'skiperator.kartverket.no/v1alpha1',
      kind: 'SKIPJob',
      metadata: {
        name: 'test-job',
      },
      spec: {
        container: {
          image: 'go-http-server-image',
        },

      },
    },
  ],
  kind: 'List',
}
