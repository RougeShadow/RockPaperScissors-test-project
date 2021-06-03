pragma solidity ^ 0.5.12;
import "./DaiToken.sol";
contract RPS{
    address public player;
    mapping (address => string) public moves;
    string public winner = "None";
    string[] public roundz;
    string public _rounds;
    uint roundCount;
    mapping(address => uint) public score;
    Dai public _daiToken;
    address player2;
    constructor(Dai daiToken) public {
        _daiToken = daiToken;
         roundz.push("Round1");
        roundz.push("Round2");
        roundz.push("Round3");
        roundz.push("Game Over");
        _rounds = roundz[0];
        _rounds = roundz[0];

    }
    event roundWin(uint scores,string  winner);

    function roundUpdate() public{
       roundCount ++;
       if (roundCount == 1){
           _rounds = roundz[1];
           winner = "None";
        }
        if (roundCount == 2){
            _rounds = roundz[2];
        }

        if (roundCount == 3){
            _rounds = roundz[0];

           if (score[player] > score[player2]){
               emit roundWin(score[player],"Alex Wins!");
               winner = "You win!";
               _daiToken.transfer(player,20);
           }else emit roundWin(score[player2],"Bob Wins!");
               winner = "player 2 wins";
               _daiToken.transfer(player2,20);
       }
    }
    function TokenGen() public {
        _daiToken.transfer(msg.sender,10000); // were working
    }
    function checkBalance() public view returns (uint user,uint contr){
          return (_daiToken.balanceOf(msg.sender),_daiToken.balanceOf(address(this)));
    }
    function enterGame(address _player2) public {
        require(_daiToken.transferFrom(msg.sender,address(this),10));
        player = msg.sender;
        require(_daiToken.transferFrom(_player2,address(this),10));
        player2 = _player2;

    }
    function checkscore() public view returns (uint,uint){
        return(score[player],score[player2]);

    }
    function MakeMove(string memory movez) public{
        moves[msg.sender] = movez;
    }

    function Play() public {

        if (keccak256(bytes(moves[player2])) == keccak256(bytes(("rock")))) {
            if (keccak256(bytes(moves[player])) == keccak256(bytes(("paper")))){
                score[player]++;
                roundUpdate();

            }
            if (keccak256(bytes(moves[player])) == keccak256(bytes(("scissors")))){
                score[player2]++;
                roundUpdate();
            }
        }
            if (keccak256(bytes(moves[player2])) == keccak256(bytes(("paper")))) {
                if (keccak256(bytes(moves[player])) == keccak256(bytes(("rock")))){
                    score[player2]++;
                    roundUpdate();
            }
                if (keccak256(bytes(moves[player])) == keccak256(bytes(("scissors")))){
                    score[player] ++;
                    roundUpdate();
            }
            }
            if (keccak256(bytes(moves[player2])) == keccak256(bytes(("scissors")))) {
                if (keccak256(bytes(moves[player])) == keccak256(bytes(("rock")))){
                    score[player] ++;
                    roundUpdate();
            }
                if (keccak256(bytes(moves[player])) == keccak256(bytes(("paper")))){
                    score[player2] ++;
                    roundUpdate();
                if (keccak256(bytes(moves[player])) == keccak256(bytes(("scissors")))){
                roundUpdate();
            }
            }
            }
    }
}
