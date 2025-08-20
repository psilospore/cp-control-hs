{-# LANGUAGE DuplicateRecordFields #-}

-- |
-- Reference python code and https://www.prismmodelchecker.org/manual/ThePRISMLanguage/Introduction
-- TODO reference looping state machine python. Defines modules, etc


module PrismAST where

data PrismAssign var = PrismAssign
    { name :: var
    , val :: Int
    } deriving (Show, Eq)

data PrismVar var ty = PrismVar
    { name :: var
    , low :: ty
    , high :: ty
    , init :: Maybe ty
    } deriving (Show, Eq)

-- condition : String
-- results : [(String,Prob)]
-- [] <condition> -> <results[0][1]> : <results[0][0]> + <results[1][1]> : <results[1][0]> + ...
data PrismTransition = PrismTransition
    { condition :: Condition
    , results :: [Result]
    , withPC :: Bool
    } deriving (Show, Eq)

addPC :: PrismTransition -> Int -> PrismTransition
addPC prismTrans pc =
    if prismTrans.withPC
    then prismTrans
    else undefined -- TODO there's string representation of condition and results that I think I'd want to change

data NDPrismTrans = NDPrismTrans
    { condition :: Condition
    , results :: [Result]
    , withPC :: Bool
    } deriving (Show, Eq)

addNDPc :: NDPrismTrans -> Int -> NDPrismTrans
addNDPc ndTrans pc =
    if ndTrans.withPC
    then ndTrans
    else undefined -- TODO there's string representation of condition and results that I think I'd want to change

-- TODO type aliases to standard types for now
type Condition = String
type Probability = Double

-- TODO I think it's the other way around according to https://www.prismmodelchecker.org/manual/ThePRISMLanguage/Introduction vs the python comments
type Result = (String, Probability)


data PrismAST var =
    IntVar (PrismVar var Int)
  | BoolVar (PrismVar var Bool)
  | Assign (PrismAssign var)
  | Transition PrismTransition
  -- TODO rest of AST nodes
  deriving (Show, Eq)

data PrismModule var = PrismModule
    { name :: String
    , variables :: [PrismVar var Int]  -- TODO only int for now
    , transitions :: [PrismTransition]
    } deriving (Show, Eq)
----------------------------------------------------------------
-- EXAMPLES --
-- TODO move this eventually
----------------------------------------------------------------

-- | Taxi variables
data TaxiVar = CTE | CTE_EST | HE | HE_EST | A -- | ... TODO anything else?
  deriving (Eq, Ord, Enum, Bounded)

instance Show TaxiVar where
  show CTE = "cte"
  show CTE_EST = "cte_est"
  show HE = "he"
  show HE_EST = "he_est"
  show A = "a"
