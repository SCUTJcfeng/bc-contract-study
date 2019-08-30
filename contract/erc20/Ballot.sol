pragma solidity ^0.5.10;

contract Ballot {

    // this declares a new complex type which will be used for variables later.
    // it will represent a single voter.
    struct Voter {
        // weight is accumulated by delegation
        uint weight;
        // if true, that person already voted
        bool voted;
        // person delegated to
        address delegate;
        // index of the voted proposal
        uint vote;
    }

    // this is a type for a single proposal
    struct Proposal {
        // short name
        bytes32 name;
        // number of accumulated votes
        uint voteCount;
    }

    address public chairPerson;

    // 投票信息字典
    // this declares a state variable that stores a `Voter` struct for each possible address
    mapping (address=>Voter) public voters;

    // a dynamically-sized array of `Proposal` structs.
    Proposal[] public proposals;

    // create a new ballot to choose one of `proposalNames`
    constructor(bytes32[] memory proposalNames) public {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 1;
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // give voter the right to vote on this ballot
    // may only be called by chari person
    function giveRightToVote(address voter) public {
        require(msg.sender == chairPerson, "only chair person can give right to vote");
        require(!voters[voter].voted, "the voter has already voted");
        require(voters[voter].weight == 0, "the voter weight should be 0");
        // voter 初始权重为1
        voters[voter].weight = 1;
    }

    // 你的投票权将跟随to
    // delegate your vote to voter `to`
    function delegate(address to) public {
        address tempTo = to;
        // assigns reference
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "you already voted.");
        require(tempTo != msg.sender, "you don't vote for yourself");

        // 找到委托的最终对象X, 这个对象X投的对象Y, 就是你要投的对象Y
        // forward the delegation as long as `tempTo` also delegated.
        // in general, such loops are very dangerous...
        while (voters[tempTo].delegate != address(0)) {
            tempTo = voters[tempTo].delegate;
            require(tempTo != msg.sender, "found loop in delegation");
        }
        sender.voted = true;
        sender.delegate = tempTo;
        Voter storage final_delegate = voters[tempTo];
        if (final_delegate.voted) {
            // to已经投票了 所以直接往增加voteCount
            proposals[final_delegate.vote].voteCount += sender.weight;
        } else {
            // 还没投票, 可以往权重里加
            final_delegate.weight += sender.weight;
        }
    }

    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "already voted.");
        sender.voted = true;
        sender.vote = proposal;
        // 权重用于投票
        proposals[proposal].voteCount += sender.weight;
    }

    // 遍历投票情况, 选出最高投票的人
    function winningProposal() public view returns (uint winningProposal_) {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    function winnerName() public view returns (bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }
}