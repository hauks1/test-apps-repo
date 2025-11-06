{
  apiVersion: 'v1',
  items: [
    {
      apiVersion: 'skiperator.kartverket.no/v1beta1',
      kind: 'SKIPJob',
      metadata: {
        name: 'beta-test-job',
      },
      spec: {
        image: 'go-http-server',
        cron: {
          schedule: '* * * * *'
        }

      },
    },
  ],
  kind: 'List',
}
