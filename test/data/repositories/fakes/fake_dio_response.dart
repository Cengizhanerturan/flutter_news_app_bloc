import 'package:dio/dio.dart';

Response fakeDioResponseSuccess() {
  return Response(
    requestOptions: RequestOptions(path: 'top-headlines'),
    statusCode: 200,
    data: {
      "status": "ok",
      "totalResults": 65,
      "articles": [
        {
          "source": {"id": "cnn", "name": "CNN"},
          "author": "Matt Egan",
          "title":
              "A \$6 billion nuclear deal has Trump’s name all over it. It’s raising serious ethics concerns - CNN",
          "description":
              "The Trump business empire’s expansion into nuclear fusion is alarming ethics experts who warn it poses glaring conflicts of interest and risks the federal government playing favorites in what has been seen as the holy grail of clean energy.",
          "url": "https://www.cnn.com/2025/12/22/business/trump-stock-fusion",
          "urlToImage":
              "https://media.cnn.com/api/v1/images/stellar/prod/dpk-tae-technologies-power-management-cabinets-employees-1.jpg?c=16x9&q=w_800,c_fill",
          "publishedAt": "2025-12-22T10:00:02Z",
          "content":
              "The Trump business empires expansion into nuclear fusion is alarming ethics experts, who warn it poses glaring conflicts of interest and risks the federal government playing favorites in what could b… [+6264 chars]",
        },
        {
          "source": {"id": "cnn", "name": "CNN"},
          "author": "CNN",
          "title":
              "How to put some of Warren Buffett’s best money and life advice to work for you - CNN",
          "description": null,
          "url":
              "https://www.cnn.com/2025/12/22/business/warren-buffett-financial-advice",
          "urlToImage": null,
          "publishedAt": "2025-12-22T10:00:02Z",
          "content": null,
        },
        {
          "source": {"id": null, "name": "NPR"},
          "author": "",
          "title": "Can Americans learn to love tiny, cheap kei cars? - NPR",
          "description":
              "President Trump recently embraced kei cars, tiny vehicles that are popular in Asia but hard to get in the U.S. Kei car enthusiasts are delighted — but doubt whether much will change.",
          "url":
              "https://www.npr.org/2025/12/22/nx-s1-5644937/kei-cars-tiny-vehicles",
          "urlToImage":
              "https://npr.brightspotcdn.com/dims3/default/strip/false/crop/4788x2692+977+676/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Ffe%2F52%2F72acc4d14caa806167de75a895fd%2F20251213-nrr-kei-cars-1460.jpg",
          "publishedAt": "2025-12-22T10:00:00Z",
          "content":
              "Sitting in the Oval Office this month, President Trump went on one of his trademark riffs, an aside about vehicles that are popular in Asia but impossible to buy new in the United States.\r\n\"They have… [+6566 chars]",
        },
        {
          "source": {
            "id": "the-washington-post",
            "name": "The Washington Post",
          },
          "author": "R. Eric Thomas",
          "title":
              "Column | Asking Eric: 12-step sponsor shares too much about sponsee - The Washington Post",
          "description":
              "How can letter writer trust sponsor who shared private details about her other sponsee?",
          "url":
              "https://www.washingtonpost.com/advice/2025/12/22/asking-eric-sponsor-overshares-information/",
          "urlToImage":
              "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/5MQ3UZKPPNC47EOER4GGCXUB7U.jpg&w=1440",
          "publishedAt": "2025-12-22T08:34:03Z",
          "content":
              "Dear Eric: I am in a 12-step program. We have rules about anonymity and confidentiality, specifically that what is shared in a meeting stays at the meeting, and I trust that this applies to informati… [+293 chars]",
        },
        {
          "source": {"id": null, "name": "Financial Times"},
          "author": "Malcolm Moore",
          "title":
              "North Sea operator Harbour Energy buys Gulf of Mexico oil company LLOG for \$3.2bn - Financial Times",
          "description":
              "UK company strikes deal as it seeks to expand internationally",
          "url":
              "https://www.ft.com/content/b19202d2-c0e0-4d24-aa2d-4cde9220f303",
          "urlToImage":
              "https://images.ft.com/v3/image/raw/https%3A%2F%2Fd1e00ek4ebabms.cloudfront.net%2Fproduction%2F9293952a-2c6c-4726-a5cb-6bacfbdc3d7a.jpg?source=next-barrier-page",
          "publishedAt": "2025-12-22T08:20:37Z",
          "content":
              "Then \$75 per month. Complete digital access to quality FT journalism on any device. Cancel anytime during your trial.",
        },
        {
          "source": {"id": null, "name": "CNBC"},
          "author": "Tasmin Lockwood",
          "title":
              "European markets expected to open in negative territory ahead of short trading week - CNBC",
          "description":
              "It follows a record-breaking previous session which saw the Stoxx 600 index hit 588.07 points.",
          "url":
              "https://www.cnbc.com/2025/12/22/european-markets-expected-to-open-negative-stoxx-600-dax-cac40.html",
          "urlToImage":
              "https://image.cnbcfm.com/api/v1/image/104990226-GettyImages-83059152.jpg?v=1766386289&w=1920&h=1080",
          "publishedAt": "2025-12-22T07:04:25Z",
          "content":
              "LONDON European markets opened in negative territory on Monday as last week's positive sentiment wears off.\r\nThe pan-European Stoxx 600 was 0.1% lower at the opening bell. \r\nIt follows a record-break… [+2224 chars]",
        },
        {
          "source": {"id": null, "name": "CNBC"},
          "author": "Dylan Butts",
          "title":
              "Uber, Lyft set to trial robotaxis in the UK in partnership with China's Baidu - CNBC",
          "description":
              "Chinese tech giant Baidu has announced plans to bring autonomous vehicles to London through its partnerships with Lyft and Uber, with testing to begin next year.",
          "url":
              "https://www.cnbc.com/2025/12/22/uber-lyft-set-to-trial-robotaxis-uk-in-partnership-chinas-baidu.html",
          "urlToImage":
              "https://image.cnbcfm.com/api/v1/image/108244571-1766385802383-gettyimages-2152484697-CHINA_BAIDU_APOLLO.jpeg?v=1766385825&w=1920&h=1080",
          "publishedAt": "2025-12-22T06:55:04Z",
          "content":
              "Chinese tech giant Baidu has announced plans to bring robotaxis to London starting next year through its partnerships with Lyft and Uber, as the UK emerges as a growing autonomous vehicle battlegroun… [+1948 chars]",
        },
        {
          "source": {"id": null, "name": "CNBC"},
          "author": "Lee Ying Shan",
          "title":
              "AI-linked IPOs in China are exploding. But it's not easy for foreigners to join the party - CNBC",
          "description":
              "China's hottest artificial-intelligence listings are delivering eye-popping gains. However, it may not be easy for overseas investors to partake in the rally.",
          "url":
              "https://www.cnbc.com/2025/12/22/metax-moore-threads-ipos-exploded-but-its-not-easy-for-foreigners-to-join-the-party.html",
          "urlToImage":
              "https://image.cnbcfm.com/api/v1/image/108237068-1764903745914-gettyimages-2243586882-Illustration_Moore_Threads.jpeg?v=1765983260&w=1920&h=1080",
          "publishedAt": "2025-12-22T04:13:00Z",
          "content":
              "China's hottest artificial-intelligence listings are delivering eye-popping gains.\r\nShares of chipmaker MetaX Integrated Circuits skyrocketed almost 700% in their Shanghai market debut last week, whi… [+4964 chars]",
        },
        {
          "source": {"id": null, "name": "Financial Times"},
          "author": "Leo Lewis",
          "title":
              "Japan official warns on yen’s ‘sudden’ weakness - Financial Times",
          "description":
              "Traders see higher potential for government intervention to support currency",
          "url":
              "https://www.ft.com/content/992d0372-d856-4496-8df1-ee1a0ca4329a",
          "urlToImage":
              "https://images.ft.com/v3/image/raw/https%3A%2F%2Fd1e00ek4ebabms.cloudfront.net%2Fproduction%2Fd9989b5b-0b11-43c3-af90-a6ddc70ca74c.jpg?source=next-barrier-page",
          "publishedAt": "2025-12-22T03:32:30Z",
          "content":
              "Then \$75 per month. Complete digital access to quality FT journalism on any device. Cancel anytime during your trial.",
        },
        {
          "source": {"id": null, "name": "San Francisco Chronicle"},
          "author": "Aidin Vaziri",
          "title":
              "Waymo robotaxis are back on San Francisco streets after blackout - San Francisco Chronicle",
          "description":
              "Waymo restored driverless taxi service in San Francisco after a widespread power outage knocked out traffic signals and caused citywide gridlock.",
          "url":
              "https://www.sfchronicle.com/bayarea/article/waymo-san-francisco-power-outage-21255470.php",
          "urlToImage":
              "https://s.hdnux.com/photos/01/55/45/25/28726620/8/rawImage.jpg",
          "publishedAt": "2025-12-22T01:11:31Z",
          "content":
              "A Waymo robotaxi sits in traffic in San Franciscos Mission District during a PG&amp;E outage on Saturday, Dec. 20, 2025. Waymos autonomous ride-hailing service remained suspended Sunday morning after… [+3491 chars]",
        },
        {
          "source": {
            "id": "the-wall-street-journal",
            "name": "The Wall Street Journal",
          },
          "author": "P.R. Venkat",
          "title":
              "Permira-, Warburg-Led Consortium to Acquire Clearwater Analytics in \$8.4B Deal - The Wall Street Journal",
          "description":
              "Upon completion of the transaction, Clearwater Analytics will delist from the New York Stock Exchange and become a privately held company.",
          "url":
              "https://www.wsj.com/business/deals/permira-warburg-led-consortium-to-acquire-clearwater-analytics-in-8-4b-deal-a1ce43b0",
          "urlToImage": "https://images.wsj.net/im-36775942/social",
          "publishedAt": "2025-12-22T00:47:00Z",
          "content": null,
        },
        {
          "source": {"id": null, "name": "NPR"},
          "author": "Joe Hernandez",
          "title":
              "How a power outage in Colorado caused U.S. official time be 4.8 microseconds off - NPR",
          "description":
              "Officials said the error is likely be too minute for the general public to clock it, but it could affect applications such as critical infrastructure, telecommunications and GPS signals.",
          "url":
              "https://www.npr.org/2025/12/21/nx-s1-5651317/colorado-us-official-time-microseconds-nist-clocks",
          "urlToImage":
              "https://npr.brightspotcdn.com/dims3/default/strip/false/crop/612x344+158+0/resize/1400/quality/100/format/png/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Fdf%2Ff8%2Fcc8daf7c423392c77e321d4d4e72%2Fcesium-beam-and-hydrogen-maser.png",
          "publishedAt": "2025-12-22T00:11:07Z",
          "content":
              "The U.S. government calculates the country's official time using more than a dozen atomic clocks at a federal facility northwest of Denver.\r\nBut when a destructive windstorm knocked out power to the … [+2329 chars]",
        },
        {
          "source": {"id": null, "name": "BBC News"},
          "author": null,
          "title":
              "Epidural kit shortage could last until March, regulator says - BBC",
          "description":
              "The shortage is due to a major supplier stopping manufacturing epidural bags, the government says.",
          "url": "https://www.bbc.com/news/articles/c5ydznpyj58o",
          "urlToImage":
              "https://ichef.bbci.co.uk/news/1024/branded_news/a4fd/live/c1a59f80-deb1-11f0-8ce7-9dd1e62bbc74.jpg",
          "publishedAt": "2025-12-21T22:03:36Z",
          "content":
              "A shortage of epidural kits in the UK is expected to last until at least March, the government's medicines regulator has warned.\r\nThe Medicines and Healthcare products Regulatory Agency (MHRA) told h… [+1822 chars]",
        },
        {
          "source": {"id": null, "name": "amNY"},
          "author": "Barbara Russo-Lennon",
          "title":
              "MTA unveils new blaring-alarm fare gates at busy NYC stations to fight fare evasion - amNewYork",
          "description":
              "The MTA unveiled new blaring-alarm fare gates that add to other fare evasion efforts, including gate guards, sleeves and more at NYC stations.",
          "url":
              "http://www.amny.com/nyc-transit/new-blaring-alarm-fare-gates-fare-evasion-nyc/",
          "urlToImage":
              "https://www.amny.com/wp-content/uploads/2025/12/DSC_8538-copy.jpg?quality=51&w=1200&p=q",
          "publishedAt": "2025-12-21T20:31:02Z",
          "content":
              "The MTA unveiled its latest effort last to fight fare evasion at two NYC stations, but commuters looking for a free ride still found creative ways to beat the system. \r\nThe entrances to trains at Bro… [+3902 chars]",
        },
        {
          "source": {"id": null, "name": "OregonLive"},
          "author": "Lizzy Acker | The Oregonian/OregonLive",
          "title":
              "Portland-based meat company recalls ready-made sausage - OregonLive.com",
          "description":
              "Double-check your sausage before putting it out for guests this holiday season.",
          "url":
              "https://www.oregonlive.com/business/2025/12/portland-based-meat-company-recalls-ready-made-sausage.html",
          "urlToImage":
              "https://www.oregonlive.com/resizer/v2/DUY6UNBEQZALJOOPVQ7QDDDNIQ.png?auth=3257663eeca8b7108a668cdf7d9c206b90223b95b22fc1ab0f2ac1a554bfe361&width=1280&smart=true&quality=90",
          "publishedAt": "2025-12-21T20:14:00Z",
          "content":
              "Double-check your sausage before putting it out for guests this holiday season.\r\nPortland-based Olympia Provisions has recalled about 1,930 pounds of ready-to-eat holiday kielbasa sausages, according… [+909 chars]",
        },
      ],
    },
  );
}

Response fakeDioResponseEmpty() {
  return Response(
    requestOptions: RequestOptions(path: '/top-headlines'),
    statusCode: 200,
    data: {},
  );
}

Response fakeDioResponseError(int statusCode) {
  return Response(
    requestOptions: RequestOptions(path: '/top-headlines'),
    statusCode: statusCode,
  );
}
