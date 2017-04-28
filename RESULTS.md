
|                                                  | clang             | icpc                         | gcc               |
|--------------------------------------------------|-------------------|------------------------------|-------------------|
| 2d std::fill w/ loop                             | vectorizes well   | vectorizes well              | vectorizes well   |
| std::fill w/ 2d index iterator-sentinel range    | doesn't vectorize | vectorizes poorly (indexing) | doesn't vectorize |
| std::fill w/ 2d index iterator-iterator range    | doesn't vectorize | doesn't vectorize            | doesn't vectorize |  
| std::fill w/ coroutine-powered 2d index iterator | vectorizes well   | N/A                          | N/A               |
