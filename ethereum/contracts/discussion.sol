pragma solidity ^0.4.17;

contract Discussion {
    struct personalPart {
        address accAddress;
        string username;
        string majorMinor;
        uint password;
    }
    struct Reply {
        address replySender;
        string replyMsg;
        uint totalLikeR;
        mapping(address => bool) likeR;
    }
    struct Question {
        address qnSender;
        string question;
        uint totalLikeQ;
        uint numReplies;
        mapping (uint => Reply) replies;
        mapping (address => bool) likeQ;
    }
    
    uint numQuestions;
    uint numUsers;
    mapping (uint => personalPart) personal; 
    mapping (uint => Question) questions;
    mapping (address => bool) userinfo;
    function createPersonal (string username, string majorMinor, string password) 
        public returns (uint) { 
            personal[numUsers] = personalPart(msg.sender, username, majorMinor, uint(keccak256(password)));
            createAccount();
        }
    function createAccount () public {
        numUsers++;
        userinfo[msg.sender] = true;
    }
    
    function newQuestionID (string question) public returns (uint questionIndex) {
        require(userinfo[msg.sender]);
        questionIndex = numQuestions++;
        questions[questionIndex] = Question(msg.sender, question, 0, 0); 
    }
    
    function replyQuestion (string replyMsg, uint questionIndex) public returns(uint replyIndex) {
        require(userinfo[msg.sender]);
        require(questionIndex < numQuestions);
        Question storage qn = questions[questionIndex];
        replyIndex = qn.numReplies++;
        qn.replies[replyIndex] = Reply(msg.sender, replyMsg, 0); // give initial like = 0
        // replyIndex = numReplies; masalah : banyak nya replies gakbisa ganti2            

    }
    
    function giveLikeQn (uint questionIndex) public {
        Question storage qn = questions[questionIndex];
        require(userinfo[msg.sender]);
        require(!qn.likeQ[msg.sender]);
        qn.likeQ[msg.sender] = true;
        qn.totalLikeQ++;
    }
    
    function giveLikeRe (uint replyIndex, uint questionIndex) public {
        Question storage qn = questions[questionIndex];
        require(userinfo[msg.sender]);
        require(!qn.replies[replyIndex].likeR[msg.sender]);
        qn.replies[replyIndex].likeR[msg.sender] = true;
        qn.replies[replyIndex].totalLikeR++;
        
    }
    /*
    function seeReply (uint questionIndex, uint replyIndex) public view 
        returns(address replySender, string replyMsg, uint totalLikeR) 
        {
            Question storage qn = questions[questionIndex];
            return (qn.replies[replyIndex].replySender, qn.replies[replyIndex].replyMsg, 
                qn.replies[replyIndex].totalLikeR);
        }
    function seePersonal (uint index) public view returns(address accAddress, string username, string majorMinor, uint password)
    {
        personalPart storage pp = personal[index];
        return (pp.accAddress, pp.username, pp.majorMinor, pp.password);
    }
    */
}
