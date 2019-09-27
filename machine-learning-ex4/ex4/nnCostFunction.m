function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
% ʹ��reshape���н���������ת��Ϊ������ʽ
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);% 5000��
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));% Theta1 has size 25 x 401 
Theta2_grad = zeros(size(Theta2));% Theta2 has size 10 x 26


% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
X =[ones(m,1) X];
% ǰ�򴫲�
% z(2)
a2 = sigmoid(X * Theta1');
% 5000*26
a2 = [ones(size(a2,1),1), a2];
% 5000*10
% z(3)
a3 = sigmoid(a2 * Theta2'); 
% 10*5000
a3 = a3';
% �����������yתΪ0-1������ʽ
yy = zeros(num_labels,m);
for i = 1:m
    yy(y(i),i) = 1;
end
% ������ۺ�����δ���򻯣�
% 10 * 5000
J = (1/m)*sum(sum( (-yy).*log(a3)-(1-yy).*log(1-a3) ));

% ����ǰ�򴫲�
% ���������theta�ó�ȥ��Ҫ����
tt1 = Theta1(:,2:size(Theta1,2));
tt2 = Theta2(:,2:size(Theta2,2));
reg = lambda/(2*m)*(sum( sum(tt1.^2))+ sum(sum(tt2.^2)));
% ����������
J = J + reg;

% ���򴫲�
for t = 1 : m
    a1 = X(t,:);% 1*401
    z2 = Theta1 * a1';% 25*1
    a2 = sigmoid(z2);
    a2 = [1;a2];%26*1
    z3 = Theta2 * a2;%10*1
    a3 = sigmoid(z3);
    
    z2 = [1;z2];%26*1
    delta3 = a3 - yy(:,t);%10*1
    delta2 = (Theta2'*delta3).*sigmoidGradient(z2);
    delta2 = delta2(2:end);%25*1
%     size(delta2)
%     size(a1)
    Theta2_grad = Theta2_grad+ delta3*a2';%10*26
    Theta1_grad = Theta1_grad + delta2*a1;%25*401
end

Theta2_grad(:,1) = Theta2_grad(:,1)./m;
Theta2_grad(:,2:end) = Theta2_grad(:,2:end)./m + lambda * Theta2(:,2:end)./m;

Theta1_grad(:,1) = Theta1_grad(:,1)./m;
Theta1_grad(:,2:end) = Theta1_grad(:,2:end)./m + lambda * Theta1(:,2:end)./m;


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
