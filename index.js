(async () => {
  process.env.debug = true
  const { writeFile } = require('fs').promises
  const wq = require('@alheimsins/webquality')
  const sourceFile = process.argv[2]
  let pages = require(`./sources/${sourceFile}`)
  let data = []
  console.log(`Got ${pages.length} pages`)
  const next = async () => {
    if (pages.length > 0) {
      const now = new Date()
      let page = pages.pop()
      console.log(`Now checking: ${page.name}`)
      page.date = now
      page.timeStamp = now.getTime()
      try {
        const result = await wq(page.url)
        console.log(`Finished checking: ${page.name}`)
        page.result = result
        data.push(page)
        await next()
      } catch (error) {
        console.error(`Failed checking: ${page.name} - ${error}`)
        page.retries = !page.retries ? 0 : page.retries++
        if (page.retries < 3) {
          // Adds page back in the queue
          pages.unshift(page)
        }
        await next()
      }
    } else {
      await writeFile(`data/${sourceFile}`, JSON.stringify(data, null, 2), 'utf-8')
      console.log('Finished')
      process.exit(0)
    }
  }
  await next()
})()
