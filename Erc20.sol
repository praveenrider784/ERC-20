// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;
contract Praveen{
    event _transfer(address from,address to,uint tokens);
    event approval(address tokenowner,address spender,uint tokens );
    
    string public constant name = "Praveen";
    string public constant symbol = "PN";
    uint8 public constant decimals = 18;
    mapping(address=>uint)balances;
    mapping(address=>mapping(address=>uint)) allowed;
    uint256 _totalsupply;
    constructor(uint256 total) public{
      _totalsupply=total;
      balances[msg.sender]=_totalsupply;
    }
   function totalsupply() public view returns(uint256){
       return _totalsupply;
   }
    function balnceof(address tokenowner) public view returns(uint256){
        return balances[tokenowner];
    }
      function transfer(address receiver, uint numTokens) public  {
             
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] -= numTokens;
        balances[receiver] += numTokens;
        emit _transfer(msg.sender, receiver, numTokens);
    }
    function approve(address delegate,uint tokens) public{
        allowed[msg.sender][delegate]=tokens;
        emit approval(msg.sender,delegate,tokens);
    }
    function allowance(address owner,address delegate) public view returns(uint){
        return allowed[owner][delegate];
    }
    function transferfrom(address owner,address buyer,uint tokens) public{
        require(tokens<=balances[owner]);
        require(tokens<=allowed[owner][msg.sender]);
        balances[owner]-=tokens;
        allowed[owner][msg.sender]-=tokens;
        balances[buyer]+=tokens;
         emit _transfer(owner, buyer, tokens);
    }

}
