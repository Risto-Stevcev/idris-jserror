module Test.Data.JSError

import Data.JSError

%lib Node "fs"

readFile : String -> JS_IO ()
readFile path = foreign FFI_JS "fs.readFileSync(%0)" (String -> JS_IO ()) path

err : JSError
err = mkError "Foobar"

namespace Main
  export
  main : JS_IO ()
  main = do
    putStrLn' (message err)
    putStrLn' (show $ isJust $ stack err)
    catch (putStrLn' . show) $ readFile "non-existent-file"
    catch (putStrLn' . message) $ throw err
