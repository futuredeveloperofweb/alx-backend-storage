-- script that creates a stored procedure ComputeAverageWeightedScoreForUser.
-- that computes and store the average weighted score for a student
CREATE PROCEDURE ComputeAverageWeightedScoreForUser (IN user_id INT)
BEGIN
    DECLARE sum_weighted_scores FLOAT;
    DECLARE total_weight FLOAT;

    SELECT SUM(c.score * p.weight), SUM(p.weight)
    INTO sum_weighted_scores, total_weight
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;

    DECLARE avg_weighted_score FLOAT;
    SET avg_weighted_score = sum_weighted_scores / total_weight;

    UPDATE users
    SET average_score = avg_weighted_score
    WHERE id = user_id;
END //
