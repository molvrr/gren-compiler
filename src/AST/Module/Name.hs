{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}
module AST.Module.Name where

import Data.Binary
import qualified Data.Text as Text
import Data.Text (Text)

import qualified Elm.Package as Package


type Raw = Text -- must be non-empty


data Canonical = Canonical
    { _package :: Package.Name
    , _module :: Raw
    }
    deriving (Eq, Ord, Show)


inVirtualDom :: Raw -> Canonical
inVirtualDom raw =
  Canonical Package.virtualDom raw


inCore :: Raw -> Canonical
inCore raw =
  Canonical Package.core raw


inHtml :: Raw -> Canonical
inHtml raw =
  Canonical Package.html raw


inWebGL :: Raw -> Canonical
inWebGL raw =
  Canonical Package.webgl raw


inLinearAlgebra :: Raw -> Canonical
inLinearAlgebra raw =
  Canonical Package.linearAlgebra raw


toString :: Raw -> String
toString name =
  Text.unpack name


canonicalToString :: Canonical -> String
canonicalToString (Canonical _ name) =
  toString name


isNative :: Raw -> Bool
isNative name =
  Text.isPrefixOf "Native." name


canonicalIsNative :: Canonical -> Bool
canonicalIsNative (Canonical _ name) =
  isNative name


instance Binary Canonical where
    put (Canonical home name) =
        put home >> put name

    get =
        Canonical <$> get <*> get