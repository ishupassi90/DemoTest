@testable import PingSDK_Sources

log(
    api: "https://httpbin.org/post",
    lat: 10.0,
    lon: 10.0,
    callback: { data in
        print(data)
    }
)
