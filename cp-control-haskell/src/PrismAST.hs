-- |
-- Reference python code and https://www.prismmodelchecker.org/manual/ThePRISMLanguage/Introduction


module PrismAST where

data PrismAST =
    IntVar (PrismVar Int)
  | BoolVar (PrismVar Bool)
  | Assign PrismAssign
  | Transition PrismTransition
  -- TODO rest of AST nodes
  deriving (Show, Eq, Ord)

data PrismVar a = PrismVar a
    { name :: String
    , low :: a
    , high :: a
    , init :: Maybe a
    , desc :: String
    } deriving (Show, Eq)

data PrismAssign = PrismAssign
    { name :: Stringg
    , val :: Int
    } deriving (Show, Eq)


-- condition : String
-- results : [(String,Prob)]
-- [] <condition> -> <results[0][1]> : <results[0][0]> + <results[1][1]> : <results[1][0]> + ...
data PrismTransition = PrismTransition
    { condition :: String
    , results :: [(String, Double)]
    } deriving (Show, Eq)
